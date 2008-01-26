From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  (linux.* mail to news gateway)
Date: Sat, 26 Jan 2008 22:08:28 +0100
Message-ID: <200801262208.28859.bzolnier@gmail.com>
References: <200801262043.17739.bzolnier@gmail.com> <E1JIrgj-0005cj-Gv@faramir.fjphome.nl> <Pine.LNX.4.64.0801262142300.15243@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756146AbYAZU4I@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0801262142300.15243@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-ide@vger.kernel.org

On Saturday 26 January 2008, Jan Engelhardt wrote:
> 
> On Jan 26 2008 21:31, Frans Pop wrote:
> >>  config BLK_DEV_IDE_PMAC
> >> -       bool "Builtin PowerMac IDE support"
> >> +       tristate "Builtin PowerMac IDE support"

this change is no-op at the moment because the next Kconfig line is:

	depends on PPC_PMAC && IDE=y && BLK_DEV_IDE=y

[ PPC-specific IDE host drivers are still a special case because they are
  using ppc_ide_md architecture hooks instead of doing proper host driver
  initialization sequence - to be fixed after adding warm-plug support... ]

> >This does not seem to make sense: if the option is now tristate, it is no
> >longer "Builtin", so probably s/Builtin // in the description.
> 
> Or something like s/Builtin/Onboard/;

Please send a patch.

Thanks,
Bart
