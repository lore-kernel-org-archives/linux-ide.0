From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: libata PATA patches
Date: Tue, 08 Nov 2005 16:46:24 +0000
Message-ID: <1131468384.25192.56.camel@localhost.localdomain>
References: <1131460386.25192.45.camel@localhost.localdomain>
	 <20051108141340.GT3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932409AbVKHQRl@vger.kernel.org>
In-Reply-To: <20051108141340.GT3847@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-11-08 at 15:13 +0100, Adrian Bunk wrote:
> Shouldn't the following at the top of arch/i386/Makefile already do the 
> same?
> 
> HAS_BIARCH      := $(call cc-option-yn, -m32)
> ifeq ($(HAS_BIARCH),y)
> AS              := $(AS) --32
> LD              := $(LD) -m elf_i386
> CC              := $(CC) -m32
> endif
> 

Its just left overs from my old build patches I forgot to clean out.
Harmless however.
