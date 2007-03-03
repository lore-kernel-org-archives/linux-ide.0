From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/3] libata: add missing PM callbacks
Date: Sat, 03 Mar 2007 12:11:05 +0900
Message-ID: <45E8E749.4030406@gmail.com>
References: <20070302083001.GK20322@htj.dyndns.org> <45E8B3C8.2090009@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992959AbXCCDLK@vger.kernel.org>
In-Reply-To: <45E8B3C8.2090009@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

[cc'ing Pavel and linux-kernel, hello]

Original thread can be read from

  http://thread.gmane.org/gmane.linux.ide/16475

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Some LLDs were missing scsi device PM callbacks while having host/port
>> suspend support.  Add missing ones.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> applied 1-3, though I agree with Alan that a non-ifdef solution should
> be sought (by the PM & PCI people?), where possible

Agreed, CONFIG_PM ifdefs are all over low level drivers, libata or not,
and ugly as hell.  Maybe use separate section, mark functions with
__power and drop them at link time is a better idea.  With linker
tricks, we can make references to __power symbols NULL.  How does it sound?

-- 
tejun
