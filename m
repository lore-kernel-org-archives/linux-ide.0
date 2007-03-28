From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Why is NCQ enabled by default by libata? (2.6.20)
Date: Wed, 28 Mar 2007 10:42:47 -0400
Message-ID: <460A7EE7.5070101@cfl.rr.com>
References: <20070327161616.31448.qmail@science.horizon.com> <Pine.LNX.4.64.0703271224400.5965@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752169AbXC1Omn@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0703271224400.5965@p34.internal.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux@horizon.com, htejun@gmail.com, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Justin Piszcz wrote:
> I would try with write-caching enabled.
> Also, the RAID5/RAID10 you mention seems like each volume is on part of
> the platter, a strange setup you got there :)

Shouldn't NCQ only help write performance if write caching is 
_disabled_?  Since write cache essentially is just non tagged command 
queuing?
