From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression: SATA disk double spin-off during hibernation on hp nx6325
Date: Thu, 4 Sep 2008 16:05:20 +0200
Message-ID: <200809041605.22055.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <200808291257.33690.rjw@sisk.pl> <200808291330.42265.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200808291330.42265.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, trenn@suse.de, htejun@gmail.com, hancockr@shaw.ca, linux-kernel@vger.kernel.org, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Friday, 29 of August 2008, Frans Pop wrote:
> On Friday 29 August 2008, Rafael J. Wysocki wrote:
> > Suspend to RAM is fine, hibernation (aka suspend to disk) is not (on my
> > box). Does it mean that hibernation is fine on your box with
> > 2.6.27-rc5, although shutdown is not?  That would require special
> > DMI-dependent handling, so please double check.
> 
> Ah, right. The double spin down happens during hibernation too.
> 
> > Anyway, please attach the output of dmidecode to
> > http://bugzilla.kernel.org/show_bug.cgi?id=8855
> > so I can include your box into the final version of the patch.
> 
> Done.

I have uploaded a new version of the patch into the Bugzilla:
http://bugzilla.kernel.org/attachment.cgi?id=17618&action=view

Can you test it, please (also please attach dmesg output to the Bugzilla
entry)?

Thanks,
Rafael
