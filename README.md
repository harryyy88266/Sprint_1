# Sprint_1
Cafeteria Management System (CMS)
// today we are going to represent our project in which we are implementing a cafeteria system, 
// for the billimg sysem and updating many items for admin we use doubly link list as a data structure 
//it is very suitable and efficient for billing system
 
// we are importing liabrary

#include<stdio.h> 
#include<stdlib.h>
#include<string.h>

struct Admin // we can create structure of admin for username and password
{
    char username[30];
    char password[20];
};

struct Item // for item we crete structure which contain name, ratting, price, food_id_no, for pointer that item *next, item *prev 
{  
     char name[50];
     float rating;
     float price;
     int food_Id_No;
     struct Item *next;
     struct Item *prev;
};

// after we made a variable like  cust_id, head of pointer, last of pointer, todays_customer, total_income 

int cust_id=1;
struct Item* head;
struct Item* last;
int Today_custmer=0;
float total_income=0;

struct order_hist // after we create another structure which contain history of order done by the costmer
{
	// in this we have customer_id, item, amount = which is toatl amont of our item, char date, previous and next pointer of oder_hist

	int Customer_ID;
	int items[10][2];
	float amount;
	char date[11];
	struct order_hist *next;
	struct order_hist *prev;
};

// after that we have two pointer that is head1 and last1 for oder_hist of doubly linked list

struct order_hist* head1;
struct order_hist* last1;

struct Item* getnewNode(char a[],float p,int fin) // after that we make getnewNode Function() of item which return a new node of item
						// and we pass the character name array, float p which is price, and there is fin which is food_Id_No
{
    struct Item* temp=(struct Item*)malloc(sizeof(struct Item)); // then we make a temporary variable which point item
					
    temp->food_Id_No=fin;  // struct item we have initillize food_id_No with fin
    strcpy(temp->name,a);  // we can copy a string with 'a' temp varible  name
    temp->rating=4.0; // we give rating of all item in a rate of 4
    temp->price=p;   // then we initillize prize 
    temp->next=NULL;  // we initillize next pointer to the Null 
    temp->prev=NULL;   // we initillize prev pointer to the Null
    return temp;     // after that we return temporary item
}

void insert(char n[],float p,int fin) // in void insert function() passes a three varible charecter name, float price, int food_Id_No
{
     struct Item* temp1=getnewNode(n,p,fin); // after that we create temp1 variable we getnewNode
	 if(head==NULL)  // then we check head is Null
	 {  // if Null then we check head and last initillize to temp1
	 	head=temp1;
	 	last=temp1;
	 }

    else
	{

	 	temp1->prev=last;  //hence temp1 there is prev equal to last
	 	last->next=temp1;  // last is next equal to temp
	 	last=temp1;  // and last pointer is initillize to temp1
        }
}

struct order_hist* getnewNode_hist()  //food order history
				    // in food order history getnewNode we inilillize temp variable 
{
	struct order_hist* temp=(struct order_hist*)malloc(sizeof(struct order_hist));
	temp->next=temp->prev=NULL;  and that temp variable we initillize next and prev pointer with the Null
	return (temp);  // and in return, return a temp varible
}

void Display()
{
	printf("                                                -------------                                            \n");
	printf("-----------------------------------------------------MENU-------------------------------------------------\n");
	printf("                                                -------------                                            \n");
	printf("INDEX     ITEM NAME     PRICE       RATING\n");
	// in display the function we display the the item in a food item
	// first we make prinitf to menu and index, item name, price, rating	

    struct Item* temp=head;
    if(head==NULL) // if head pointer is Null
    {
    	printf("Empty"); // simply print a empty means no item
	}

    while(temp!=NULL)  // if head is not Null then printf food_Id_No, name, price, rating
    {
    	printf("%d\t%s\t%f\t%f\n",temp->food_Id_No,temp->name,temp->price,temp->rating);
    	temp=temp->next;
	}
	printf("---------------------------------------------------------------------------------------------------------\n");
}


int login()
{
    int select;
    printf("1: Register\n2: Login\n");
    scanf("%d",&select);
    if(select==1) //register
    {
        FILE *admindetails;         //FILE TYPE pointer
    admindetails=fopen("CMS_DataBase.dat","w"); //it will create a file and write it 
    struct Admin a;                     //struct structname variablename 
    printf("enter username: ");  //username = nikhil [for black screen output]
    scanf("%s",a.username);
    printf("enter password: ");  //password = 123  [for black screen output]
    scanf("%s",a.password);
    fwrite(&a,sizeof(a),1,admindetails);    //syntax of write
    printf("\nUser registerd Successfully in Database\n");
    fclose(admindetails);

    }
    else if(select==2)  //login
    {
        char username[30],password[30];
    FILE *admindetails;
    admindetails=fopen("CMS_DataBase.dat","r");
    struct Admin a;
    printf("enter your username: ");  //nikhil
    scanf("%s",username);
    printf("enter your password: ");  //123
    scanf("%s",password);
    while(fread(&a,sizeof(a),1,admindetails))       //syntax of read
    {
        if(strcmp(username,a.username)==0 && strcmp(password,a.password)==0)
        {
            printf("\nLogin Successfully  \n");
            return 1;
        }
        else
        {
            printf("\nPlease check the User name and password\n");
            return 0;

        }

    }
    fclose(admindetails);
    }


}

void order() //taking a order
{
    int a[10][2];
    int n,j=0,i=0;

    do{	
	   // for we can ask to user for No of item and quantity of that id 
            printf("Pleaze enter the FOOD ID NUMBER OF ITEM AND ITS QUENTITY: "); //up
		                                    // item=1,     quanity=3  [for black screen output]
            for(i=0;i<2;i++)
            {
                scanf("%d",&a[j][i]); // from this we have storing in array
            }
            j++;
		// we ask for another if user want to more item or not, if yes press 1.yes and if no then press 2.no
            printf("you want More item\n1.yes\n2.no");  // yes or no  [for black screen output]
            scanf("%d",&n);
    }while(n==1);

    float total_amount=0.0;  // initillize float variable of total_ammount
    char name[25];
    char Date[10];
		// for we asking name and date for making a bill of there order
    printf("Enter your Name : ");  //nikhil  [for black screen output]
    scanf("%s",name);
    printf("Enter Today's Date : "); //  3/4/2022  [for black screen output]
    scanf("%s",Date);
    int k=0;
    printf("\n-------------------------------------------------------------------------------------------------------\n");   // genrate a bill [for black screen output]
    printf("                                          BILL                             \n");                                //next part is main menu [for black screen output]

    printf("Name:-%s\n",name);  //print name
    printf("Date:-%s\n",Date);  // print date

    for(k=0;k<j;k++)
    {
	     //after using struct item we are getting name of item and printig fill of food_Id_No, name of item, price of item,
		//and total how many quantity into item which customer ask means toatl amount of bill 
		// after that we print total payble amount

        struct Item* temp=head;
        while(temp->food_Id_No!=a[k][0])
        {
            temp=temp->next;
        }//printf("%f\n",temp->price);

        printf("-------------------------------------------------------------------------------------------------------\n");
        printf("%d\t%s\t%d\t\t%f\n",temp->food_Id_No,temp->name,a[k][1],(a[k][1]*(temp->price)));
        total_amount+=(a[k][1]*(temp->price));
    }
    printf("-------------------------------------------------------------------------------------------------------\n");
    printf("\nTotal Payble amount is:-\t\t%f\n",total_amount);
    printf("-------------------------------------------------------------------------------------------------------\n");

    struct order_hist* temp2=getnewNode_hist(); // then we make tempory variable of order_hist means history of order
			// we want to write a history of oder into a srtuct variable of oder_hist
    temp2->amount=total_amount;  // in that we initillize temp2 amount is equal to total_amount of bill
    temp2->Customer_ID=cust_id++;  // after that customer_Id is equal to cust_id++

    int p,s;

    for(p=0;p<j;p++) 
    {           // we initillize how many item user store in order history
	  	for(s=0;s<2;s++)
	  	{
	  		temp2->items[p][s]=a[p][s];
        }
    }

    if(head1==NULL) // we check if head1 is equal to Null
    {
        head1=last1=temp2; // order_hist head1 and last1 is initillize  to temp2
    }

    else // other wise not null 
    {
		last1->next=temp2; //last1 next is equal to temp2
		temp2->prev=last1; // temp2 prev is equal to last1
		last1=temp2;  //last is equal to temp2
    }

    strcpy(temp2->date,Date);

    Today_custmer++;
    total_income+=total_amount;
}


void display_rd_hist() //funtion which is storing a history of order
{
    printf("                                                       -------------                                                 \n");
    printf("\n-----------------------------------------------------ORDER HISTORY-------------------------------------------------\n");
    printf("                                                       -------------                                                 \n");
    printf("SR_NO     DATE      TOTAL AMOUNT\n");

    struct order_hist* temp=head1;  // we have initillize a tempory variable of  history struct and we have initillize a head
    if(head1==NULL) // if head equal to Null
    {
    	printf("Empty");  //printf empty means no values
	}

    while(temp!=NULL)  //other wise we print history which contain customer_ID, date, amount
    {
    	printf("%d\t%s\t%f\t\n",temp->Customer_ID,temp->date,temp->amount);
    	temp=temp->next; // temp . temp initillize next
	}
}

void main()
{
	head=NULL;  // head initillize as Null
	last=NULL;  // last initillize as Null

	insert("Burger   ",70.23,1);
	insert("Pizza    ",235.67,6);
	insert("Hot Cake ",750.83,10);
	insert("Coffie   ",70.23,2);
	insert("Ice-Cream",70.23,3);
	insert("Sandwich ",60.23,4);
	insert("Grill    ",52.29,7);
	insert("Nun-Bread",35.13,8);
	insert("Cold Drinks",20.13,9);

    int choice;

    do{
	// in admin panel they are only accessible for admin  [for black screen output]
	// they are asked for user name and password  [for black screen output]
	// there are sevral function which are not which are not accessible for customer  [for black screen output]

        printf("\n-------------------------------------------------------------------------------");
        printf("\n1....FOOD PART");
        printf("\n2....ADMIN PANEL");
        printf("\n3....EXIT");

        printf("\nEnter your choice:");
        scanf("%d",&choice);

        switch(choice)
        {
            case 1:
                printf(" ");
                int ex;

                do{
                    printf("1.       FOOD LIST\n2.       ORDER\n"); 
                    int n;
                    scanf("%d",&n);

                    switch(n)
                    {
                        case 1: Display();
                                break;
                        case 2: order();
                                break;
                    }

                    printf("1.FOOD PART\n2.MAIN MENU\n");
					scanf("%d",&ex);
				}while(ex==1);
            break;

            case 2:
                printf("\n");
                int k=login();
                int e;
                if(k==1){

                do{
			// admin can perform a sevral function
			// like 1.add new dish 2.total income 3.total no of customer 4.order history 5.list of item
				
                    printf("-------------------------------------------------------------------------------------------------------\n");
                    printf("1.     ADD NEW DISH\n");  // admin can visit and add new dish data  [for black screen output]
                    printf("2.     TODAY'S  TOTAL INCOME\n"); // admin can visit total income  [for black screen output]
                    printf("3.     TODAY TOTAL NO OF CUSTOMER\n"); // admin can visit a no of customer  [for black screen output]
                    printf("4.     ORDER HISTORY\n"); // admin can visit a order history   [for black screen output]
                    printf("5      LIST OF ITEM\n"); // admin can visit list of item  [for black screen output]
                    printf("\n------------------------------------------------------------------------------------------------------\n");

                    int ch;
                    scanf("%d",&ch);
                    switch(ch)
                    {
                        case 1:
                            printf(" ");
                            float p;
						    int fin;
							char  n[50];

							printf("Enter the name of Item"); // admin can add name of item  [for black screen output]
							scanf("%s",n);

							printf("Enter the Price of Item");  // admin can add price of item   [for black screen output] 
							scanf("%f",&p);

							printf("Enter the food_id_no of Item");  // admin can add food_id_no of item   [for black screen output]
							scanf("%d",&fin);

							insert(n,p,fin);
                            printf("-------------------------------------------------------------------------------------------------------\n");
					        printf("                 NEW DISH IS ADDED SUCESSFULLY.......\n");
                            printf("-------------------------------------------------------------------------------------------------------\n");
					        printf("\n");
                        break;

                        case 2:
                            printf("-------------------------------------------------------------------------------------------------------\n");
                            printf("        TODAY'S  TOTAL INCOME IS:- %f\n",total_income);
                            printf("-------------------------------------------------------------------------------------------------------\n");
                        break;

                        case 3:
                            printf("-------------------------------------------------------------------------------------------------------\n");
					        printf("        TODAY TOTAL NO OF CUSTOMER VISITED ID:-%d\n",Today_custmer);
                            printf("-------------------------------------------------------------------------------------------------------\n");
                        break;

                        case 4:
                            printf("-------------------------------------------------------------------------------------------------------\n");
					        printf("	                ORDER SUMMARY");
					        printf("-------------------------------------------------------------------------------------------------------\n");
                            display_rd_hist();
                            printf("\n");
                        break;

                        case 5:
                            printf("\n");
                            Display();
                        break;

					}

					printf("1.ADMIN PANEL\n2.MAIN MENU\n");
					scanf("%d",&e);

				}while(e==1);
			}
				break;
        }

    }while(choice!=3);
}
