From: venkat <venkat.s@vortexindia.co.in>
Subject: Re: SATA IDE Disk failure leasds to kernel freezing and DMESG looping
Date: Fri, 29 Nov 2013 13:28:10 +0530
Message-ID: <52984912.5070104@vortexindia.co.in>
References: <1385634640.84101.YahooMailNeo@web2705.biz.mail.sg3.yahoo.com> <52971EE6.4030301@vortexindia.co.in> <52977B7F.1040602@linux.com> <529834AD.6040100@vortexindia.co.in> <52983871.9040209@linux.com> <1385708575.44913.YahooMailNeo@web2713.biz.mail.sg3.yahoo.com> <52983E85.60207@linux.com> <52984053.3000104@vortexindia.co.in> <529842FB.8020203@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.biz.mail.sg3.yahoo.com ([106.10.167.245]:44602 "HELO
	smtp102.biz.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750871Ab3K2Hy3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Nov 2013 02:54:29 -0500
In-Reply-To: <529842FB.8020203@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <levex@linux.com>
Cc: Reddy G <reddygb@vortexindia.co.in>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Hi,

So the problem is that you connect a faulty HDD to the master drive and a
normal one to the slave drive. When your master drive evolves faulty sectors
or the SATA cable is messed up, your slave drive doesn't work. Well, that is strange.

	Ans.	No.We connect faulty HDD in SLAVE(NO-OS) and MASTER(which holds the OS) in MASTER


The ata_piix output says that the MAP register is P0 P2 IDE IDE,
which means that it doesn't matter what you plug into port one, it will *not* get detected.

		
To solve this problem, check your firmware settings for any relevant SATA/AHCI settings.

	Ans.	Unfortunately our board does not support AHCI. SO what is the best way to handle this.Is it possible to disable the Master/Slave(specific) port on HDD failure.


PS: It is entirely possible to change the MAP register in software for the ICH* series,
but it seems that you are in IDE mode. Better switch to AHCI mode.




On 29-11-2013 13:02, Levente Kurusa wrote:
> 2013-11-29 08:20, venkat:
>> Another question: What do you mean by SATA 0 and SATA 1? Are they two different controllers or are they
>> the master and slave pair for one controller? The lspci output lists exactly one SATA controller so I guess
>> its the master/slave option.
>>
>>      Yes - They are master slave pair only.
>
>


-- 
Regards
Venkat.S

