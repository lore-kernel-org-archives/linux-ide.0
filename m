From: Stefan <gentoopower@yahoo.de>
Subject: Re: Serious IDE problem still present in 2.6.14
Date: Sun, 30 Oct 2005 03:15:00 +0100
Message-ID: <43642CA4.5010109@yahoo.de>
References: <1130633310.6225.11.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:5035 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932788AbVJ3CPH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Oct 2005 22:15:07 -0400
In-Reply-To: <1130633310.6225.11.camel@montroll.chem.mcgill.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David.Ronis@mcgill.ca
Cc: linux-ide@vger.kernel.org

David Ronis wrote:

>The problem I reported on the linux-kernel list and later here.  See
>
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=112802950411697&w=2
>  
>
I just read your info there, you did not submit output of:

hdparm /dev/hda though

is using_dma switched on if you look at the output of the above command?

>with disk access on my HP pavilion is still present.  In short,
>something broke in the 2.6.13 series, and it still is broken in 2.6.14.
>One thing I hadn't added explicitly to my earlier report, is that this
>laptop has a P4 Hyperthreaded chip (someone mentioned that there was an
>ACPI problem related to hyperthreading).
>
>David
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

