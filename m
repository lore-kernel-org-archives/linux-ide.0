From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA error while resume
Date: Sun, 19 Aug 2007 19:45:32 +0900
Message-ID: <46C81F4C.2030407@gmail.com>
References: <46C80999.1060700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <46C80999.1060700@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Maciek Rutecki <maciej.rutecki@gmail.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl
List-Id: linux-ide@vger.kernel.org

Maciek Rutecki wrote:
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata1.00: irq_stat 0x40000001
> ata1.00: cmd 25/00:00:10:0b:f3/00:04:05:00:00/e0 tag 0 cdb 0x0 data
> 524288 in
>          res 51/40:a4:6c:0b:f3/00:03:05:00:00/e0 Emask 0x9 (media error)
> ata1.00: configured for UDMA/100
> 
> Then system continue booting without resume.
> 
> I use smartctl and check disk 2 times and run fsck/mkswap -c and I have
> no erros:
> 
> =================
>   5 Reallocated_Sector_Ct   0x0033   100   100   024    Pre-fail  Always
>       -       8589934592000
> 196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always
>       -       444268544

It very much looks like the disk is dying.  Dunno why it doesn't show up
during SMART testing but you better back up and contact the hardware vendor.

-- 
tejun
