From: Frans Pop <elendil@planet.nl>
Subject: Re: Regression: SATA disk double spin-off during hibernation on hp nx6325
Date: Sat, 6 Sep 2008 00:25:18 +0200
Message-ID: <200809060025.20039.elendil@planet.nl>
References: <200808290002.55026.rjw@sisk.pl> <200808291330.42265.elendil@planet.nl> <200809041605.22055.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200809041605.22055.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, trenn@suse.de, htejun@gmail.com, hancockr@shaw.ca, linux-kernel@vger.kernel.org, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Thursday 04 September 2008, Rafael J. Wysocki wrote:
> I have uploaded a new version of the patch into the Bugzilla:
> http://bugzilla.kernel.org/attachment.cgi?id=17618&action=view

This version does not work for me, possibly because I use a different hard 
disk driver (ata_piix instead of sata_sil)?

I've seen there are later versions of the patch, but as the comments 
mention that 2510p was removed from those I haven't tested them.

> (also please attach dmesg output to the Bugzilla entry)

Added.

Cheers,
FJP
