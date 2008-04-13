From: Niels <zorglub_olsen@hotmail.com>
Subject: Re: Western Digital GreenPower drives and Linux
Date: Sun, 13 Apr 2008 10:30:28 +0200
Message-ID: <ftsgb5$qi0$1@ger.gmane.org>
References: <234148243@web.de> <200804112200.28854.tvrtko@ursulin.net> <170fa0d20804112019h73928c99paadcc363539fea9c@mail.gmail.com> <200804120811.12468.tvrtko@ursulin.net> <170fa0d20804120820x1eced1ebl47b6a2f6593ea029@mail.gmail.com> <170fa0d20804120856w786b625cv41af33072605dab7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757442AbYDMIaz@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Saturday 12 April 2008 17:56, Mike Snitzer wrote:

[snip]
> 
> Turns out 'wdidle3 /R' on my drive reported:
> "Idle3 Timer is disabled"
> 
> I took no explicit action to disable it 6 months ago. It strikes me as
> odd that WD would disable the Idle3 timer in firmware given the whole
> "GreenPower" campaign but I was pleasantly surprised; others may be
> too...

A data point from me. I have two of these, sda is 400GB and has root, boot,
swap and home partitions, sdb is 1TB and has one big partition. They're in
my desktop machine, which is usually powered on in the morning and off in
the evening. It's two months old.

sda:

9 Power_On_Hours          0x0032   099   099   000    Old_age  
Always       -       785
12 Power_Cycle_Count       0x0032   100   100   000    Old_age  
Always       -       141
193 Load_Cycle_Count        0x0032   200   200   000    Old_age  
Always       -       144

sdb:

9 Power_On_Hours          0x0032   099   099   000    Old_age  
Always       -       749
12 Power_Cycle_Count       0x0032   100   100   000    Old_age  
Always       -       122
193 Load_Cycle_Count        0x0032   195   195   000    Old_age  
Always       -       17276


The last of these numbers seems fairly high, compared to what others in this
thread have reported, especially considering that the disk is quite new.


//Niels
