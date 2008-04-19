From: walt <w41ter@gmail.com>
Subject: Re: [PATCH] libata: fix boot panic with SATAPI devices on non-SFF
 HBAs
Date: Sat, 19 Apr 2008 06:34:30 -0700
Message-ID: <fucsch$ah0$1@ger.gmane.org>
References: <1208542728.3063.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1208542728.3063.25.camel@localhost.localdomain>
Sender: linux-scsi-owner@vger.kernel.org
To: linux-scsi@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

James Bottomley wrote:
> Current 2.6.25 git head now panics reliably on boot if you have a SATAPI
> device connected.
>
> The problem was introduced by the libata merge trying to pull out all
> the SFF code into a separate module...

Hi James,

When I saw your commit I thought it would fix the panic introduced by Tejun's
commit <305d2a1a>, but no luck.

I have a pata drive connected to a sata controller using a plugin adapter.
After Tejun's commit the kernel panics with unknown-block (8,9) instead of
mounting /dev/sda9.  Is this the scenario your patch is intended to fix?

