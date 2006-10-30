From: Ansgar Knappheide <ansgar.knappheide@gmx.de>
Subject: Re: sata_promise issue with SATA 300 TX4 (PDC40718)
Date: Mon, 30 Oct 2006 13:39:13 +0100
Message-ID: <4545F271.7070805@gmx.de>
References: <200610291310.01120.tbaumgartner@swissonline.ch> <4544EEC5.2020808@gmx.de> <200610292051.12066.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:19424 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932173AbWJ3MjU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Oct 2006 07:39:20 -0500
In-Reply-To: <200610292051.12066.tbaumgartner@swissonline.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Theo Baumgartner schrieb:
> Ansgar Knappheide schrieb:
>   
>> I have seen this error message on all versions of kernel 2.6 since the 
>> beginning and also on kernel 2.4 and asked about this error message some 
>> time ago, but didn't get an answer.
>> It happens on heavy random access (heavy headmovement) on disk but also 
>> on fsck(.ext3). Since kernel 2.16 or 2.6.17 (since printing "Info 
>> fld=xxxxxx) this error message is getting rare.
>> P.S. I've never seen any data corruption, so this is not a serious error 
>> for me , but might be for others.
>>     
>
> Is this only limited to sata_promise or are there also other sata/pata drivers
> that have this type of error message?
> There has to be a reason for this message. Is the controller/disk telling the
> kernel "stop pushing me or i will loose data"?
>
>   
I don't know, if there are other drivers, cause for my pata drives I use 
the "old" ide via82cxxx driver not libata pata and there I don't get any 
error messages of this type.
> And is there realy _no_ data corruption? This fileserver should store my
> picture archive and i don't/can't do every day/week backups. And as long as i get
> this message i don't trust this machine/controller/disk/kernel/driver/whatever.
>   
I have seen no really no data corruption, not even under heavy load and 
I am using the SATAII150 TX4 (I think the driver makes no difference 
between your and my controller except the the transfer rate) controller 
about a year without any problems on my productions system.
I guess this error, means something like "timeout on last command, tryed 
again with success" or similar.

I hope any of the driver programmers will soon, get on this (I'm still 
waiting for ATAPI support on this driver, cause I extra bought a SATA 
dvdwriter to be ready for future).

Ansgar Knappheide
