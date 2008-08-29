From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression: SATA disk double spin-off during hibernation on hp nx6325
Date: Fri, 29 Aug 2008 12:57:32 +0200
Message-ID: <200808291257.33690.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <200808291245.27436.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200808291245.27436.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, trenn@suse.de, htejun@gmail.com, hancockr@shaw.ca, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Friday, 29 of August 2008, Frans Pop wrote:
> Rafael J. Wysocki wrote:
> > It appears that the "double spin-off" problem described in
> > http://bugzilla.kernel.org/show_bug.cgi?id=8855
> > 
> > has recently started to appear during hibernation as well as during
> > shutdown. It didn't appear during hibernation on my hp nx6325 with
> > 2.6.26, so this is a recent regression.
> 
> FWIW, I also have the double spin-off on my HP Compaq 2510p, but only hear 
> it on shutdown and not on suspend.

Suspend to RAM is fine, hibernation (aka suspend to disk) is not (on my box).
Does it mean that hibernation is fine on your box with 2.6.27-rc5, although
shutdown is not?  That would require special DMI-dependent handling, so please
double check.

Anyway, please attach the output of dmidecode to
http://bugzilla.kernel.org/show_bug.cgi?id=8855
so I can include your box into the final version of the patch.

Thanks,
Rafael
