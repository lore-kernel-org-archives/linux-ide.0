From: Stefan <gentoopower@yahoo.de>
Subject: Re: Serious IDE problem still present in 2.6.14
Date: Thu, 10 Nov 2005 17:59:58 +0100
Message-ID: <43737C8E.90808@yahoo.de>
References: <Pine.LNX.4.44.0510301030120.26176-100000@coffee.psychology.mcmaster.ca>	 <1130689871.6348.3.camel@montroll.chem.mcgill.ca>	 <4365511C.7040903@yahoo.de>	 <1130713716.6348.7.camel@montroll.chem.mcgill.ca>	 <4365596F.4060105@yahoo.de>	 <1130785344.5932.6.camel@montroll.chem.mcgill.ca> <58cb370e0511100534tead9e71u189666789b3f4da1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:32606 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750899AbVKJRA7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 12:00:59 -0500
In-Reply-To: <58cb370e0511100534tead9e71u189666789b3f4da1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David.Ronis@mcgill.ca, Mark Hahn <hahn@physics.mcmaster.ca>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>I would suggest doing binary search on -rc and snapshot releases.
>
>http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc*
>http://kernel.org/pub/linux/kernel/v2.6/snapshots/old/patch-2.6.14-*
>
>Otherwise we can only guess what is wrong.
>
>Moreover it doesn't look like an IDE problem the real performance
>regression is in cached reads not the buffered ones.
>  
>
Exactly, that's why I advised him to send another mail to the
linux-kernel list,
since I think it is related to some of the acpi changes from 2.6.12 to
>=2.6.13.
If he switches off acpi then performance is back to normal and since
there were basically no changes in the ide code
or code for his controller it must be related to other changes.

>On 10/31/05, David Ronis <ronis@ronispc.chem.mcgill.ca> wrote:
>  
>
>>Hi Stefan,
>>
>>I tried removing the modules you suggested and reran hdparm -tT /dev/hda
>>after each.  No difference.  I also played a bit more by going to
>>single-user mode and killing off various things (like udevd).   I turned
>>off networking and removed the ethernet driver--still no change.  What
>>seemed to make a difference was to turn of the firewall and remove all
>>the ipt_ drivers, although the performance was still about 4 times less
>>than what I get with the 2.6.13.6 kernel.
>>    
>>
>
>  
>


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

