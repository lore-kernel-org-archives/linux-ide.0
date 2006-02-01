From: Tejun Heo <htejun@gmail.com>
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Date: Thu, 02 Feb 2006 08:08:07 +0900
Message-ID: <43E13F57.40808@gmail.com>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423012AbWBAXIR@vger.kernel.org>
In-Reply-To: <20060201162800.GA32196@tentacle.sectorb.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Vladimir B. Savkin wrote:
> Hello!
> 
> My system based on Asus A8V (VIA chipset) works fine with 2.6.13.3,
> but after upgrading (kernels 2.6.14.7 and 2.6.15.1 tried) it
> gaves error messages some minutes after boot.
> 
> The messages are as following:
>   ata2: command 0xXX timeout, stat 0x50 host_stat 0x4
> where XX gets different values from time to time, 0x25 mostly.
> I/O to this controller halts after that.
> 
> Attached are boot dmesg log and lspci output.
> 

[CC'ing linux-ide]

Hello, Vladimir.

How reproducible is the problem?  With how much certainty can you say 
the problem is introduced by newer kernels?  e.g. If the problem occurs 
most of the time with 2.5.15.1 but it stops happending after switching 
back to 2.6.13.3, you can be pretty sure.

Can you also please post dmesg of 2.6.13.3?

-- 
tejun
