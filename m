From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: `SATA_AHCI` not selected by default with `make olddefconfig`
Date: Fri, 24 May 2019 20:24:19 -0700
Message-ID: <91d3b405-1da0-fe89-14d3-f45043167822@infradead.org>
References: <c2733e6e-2b45-9311-1a90-67c0b814a01b@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c2733e6e-2b45-9311-1a90-67c0b814a01b@molgen.mpg.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>, Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 1/10/19 6:43 AM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> There were some PCI Kconfig changes, which seem to cause problems
> with components depending on PCI. With the attached minimal config,
> running `make olddefconfig` on Linux 4.20 and older caused
> `SATA_AHCI` to be selected. But, with Linux 5.0-rc1 it is not
> selected.
> 
> 
> Kind regards,
> 
> Paul

[adding linux-pci for posterity]

Hi Paul,

I guess this is called progress.  Anyway, it's good that you noticed and
reported it.


In 4.20 (and earlier), PCI defaults to y.
As you hint, in 5.x, PCI does not default to y, so Kconfig symbols that
depend on PCI will not be set/enabled by "make olddefconfig", including
SATA_AHCI even though SATA_AHCI is set in your old .config file.


-- 
~Randy
