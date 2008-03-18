From: "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 18 Mar 2008 10:14:40 +0100
Message-ID: <009501c888d8$7fbfd150$4d0fa8c0@M2007>
References: <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com> <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com> <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com> <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca> <20080318001513.GA2389@denix.org> <47DF4070.3040507@gmail.com> <20080318045316.GA3959@denix.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.huweb.hu ([62.112.193.37]:51047 "EHLO ns1.huweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbYCRJOx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Mar 2008 05:14:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denys Dmytriyenko <denis@denix.org>, Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

>> 199 UDMA_CRC_Error_Count    0x0008   002   001   000    Old_age 
>> line      -       798

Denys,
I did a smartctl check on 12 disks in 5 differrent servers (usually
pairs of disks sw mirrorred), and all of those - except one - had
0-s at UDMA_CRC_Error_Count.
Only one had 16 in it, this one is SAMSUNG HD300LD installed
at 2006.09.12, running 24/7, so its uptime is about 13200 hours.
However, it's pair (same disk, same uptime) have 0, which makes
me think, that it is not motherboard/controller, but cable or HDD.
(wiki says, it is: "The number of errors in data transfer via the interface
 cable as determined by ICRC (Interface Cyclic Redundancy Check)."
http://en.wikipedia.org/wiki/Self-Monitoring,_Analysis,_and_Reporting_Technology )

Is that value is growing at your server?

+

Related to my original issue (exception / hard resetting link), which later
Denys also experienced and countinued on this thread, my current status
is, that
1) I received mail from other guy, he wrote:
>> I have a similar problem with an N680SLI, as posted here:
>> http://forums.gentoo.org/viewtopic-t-641372-highlight-.html
>> Short version - 2.6.22 seems stable, anything later, unstable.
Since exhibiting the problem takes days, weeks or even months,
he can't know more, promised to write to list if he finds out anything.

2)  I replaced the MB to a different one, now it is a Gigabyte as
well, but it has no nvidia/jmicron contollers but ata_piix and achi
onboard, and - ironically - an addon sil24 card...
So far, the system running well [knock-knock], under heavy
stress test, for 3 weeks now, without problems.
I believe Tejun suggested to try to remove one of the HDD-s
online to see what happens, I will try this today later on, when
I am at the server and let you know.

(for those who need refreshment, my initial thread was on
 http://www.mail-archive.com/linux-ide@vger.kernel.org/msg15950.html
 and it continued on
 http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/8633679.html my latest mail on this topic is at: http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/8718520.html )G.
