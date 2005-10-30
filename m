From: Stefan <gentoopower@yahoo.de>
Subject: Re: Serious IDE problem still present in 2.6.14
Date: Mon, 31 Oct 2005 00:38:23 +0100
Message-ID: <4365596F.4060105@yahoo.de>
References: <Pine.LNX.4.44.0510301030120.26176-100000@coffee.psychology.mcmaster.ca>	 <1130689871.6348.3.camel@montroll.chem.mcgill.ca>	 <4365511C.7040903@yahoo.de> <1130713716.6348.7.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:22885 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751225AbVJ3Xi0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Oct 2005 18:38:26 -0500
In-Reply-To: <1130713716.6348.7.camel@montroll.chem.mcgill.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David.Ronis@mcgill.ca
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org

David Ronis wrote:

>Hi Stefan,
>
>The lspci -v output is in the email I sent to Mark (and cc'd the list).
>  
>

Ah I missed that, just took a peek at the irqs

Can you try to unload those modules for the pccard stuff and usb and
then check if that makes any difference?
I have the feeling, your problem is caused by some other modules.

>I diff'ed the output, and there are lots of differences; most seem
>trivial (addresses & IRQ's).   As to switching to the lower modes I'll
>try (maybe later tonight).
>  
>


>Thanks for your help.
>
>David
>
>
>  
>
>>
>>    
>>
>
>
>  
>


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

