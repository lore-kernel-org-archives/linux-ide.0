From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 14:27:10 +0800
Message-ID: <4B9F24BE.3070401@wytron.com.tw>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>	 <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>	 <4B9EED55.10201@kernel.org> <1268720060.21384.10.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1268720060.21384.10.camel@mulgrave.site>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Tejun Heo <tj@kernel.org>, Denys Vlasenko <vda.linux@googlemail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

On 03/16/2010 02:14 PM, James Bottomley wrote:
>
> The big problem is that 99% of the x86 systems out there still use the
> ancient msdos label for their boot disks, so aligning H/S going forwards
> will give us a nice "just works" for x86 boxes.
>
>    
The key issue is not "just work", but "performance". When unaligned, the 
write performance can be lower than 50% of the expected rate.

- Thomas
