From: Adrian Bunk <bunk@stusta.de>
Subject: Re: PATCH: libata PATA patches
Date: Tue, 8 Nov 2005 15:13:40 +0100
Message-ID: <20051108141340.GT3847@stusta.de>
References: <1131460386.25192.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965192AbVKHONm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1131460386.25192.45.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Nov 08, 2005 at 02:33:06PM +0000, Alan Cox wrote:

> I've put a new patch versus 2.6.14-mm1 on 
> http://zeniv.linux.org.uk/~alan/IDE

I'm wondering about the -m32 additions at the top of your patch.

Shouldn't the following at the top of arch/i386/Makefile already do the 
same?

HAS_BIARCH      := $(call cc-option-yn, -m32)
ifeq ($(HAS_BIARCH),y)
AS              := $(AS) --32
LD              := $(LD) -m elf_i386
CC              := $(CC) -m32
endif



> Alan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
