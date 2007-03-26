From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add _GTM and _STM support to libata
Date: Mon, 26 Mar 2007 11:58:07 +0100
Message-ID: <20070326115807.0c89ee21@the-village.bc.nu>
References: <20070326032222.GA13113@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070326032222.GA13113@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com
List-Id: linux-ide@vger.kernel.org

On Mon, 26 Mar 2007 04:22:23 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> I've ported the drivers/ide code for handling _GTM and _STM to libata. 
> I'm not utterly convinced that I'm doing the calls in the right place - 

Please see the various patches I've posted or the -mm tree. I did that
some time ago and the pata_acpi driver makes full use of them already.

All there, all done.

Alan


