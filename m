From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression: SATA disk double spin-off during hibernation on hp nx6325
Date: Sat, 6 Sep 2008 13:06:47 +0200
Message-ID: <200809061306.48377.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <200809060118.38493.rjw@sisk.pl> <200809060209.37353.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200809060209.37353.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, trenn@suse.de, htejun@gmail.com, hancockr@shaw.ca, linux-kernel@vger.kernel.org, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Saturday, 6 of September 2008, Frans Pop wrote:
> On Saturday 06 September 2008, Rafael J. Wysocki wrote:
> > Thanks.  There's a new patch for you to test in there already. :-)
> 
> Seems to work correctly. The first spindown no longer happens.
> 
> In the BTS you noted the support is "partial". What's partial about it?

I want the quirk to be only applied to on-board controllers and that wasn't
there yet for your system.

Updated patch (hopefully final) has been uploaded as:
http://bugzilla.kernel.org/attachment.cgi?id=17646&action=view

Thanks,
Rafael
