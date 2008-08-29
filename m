From: Frans Pop <elendil@planet.nl>
Subject: Re: Regression: SATA disk double spin-off during hibernation on hp nx6325
Date: Fri, 29 Aug 2008 13:30:40 +0200
Message-ID: <200808291330.42265.elendil@planet.nl>
References: <200808290002.55026.rjw@sisk.pl> <200808291245.27436.elendil@planet.nl> <200808291257.33690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml14.kpnxchange.com ([213.75.38.114]:5111 "EHLO
	hpsmtp-eml14.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753078AbYH2Lao (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Aug 2008 07:30:44 -0400
In-Reply-To: <200808291257.33690.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, trenn@suse.de, htejun@gmail.com, hancockr@shaw.ca, linux-kernel@vger.kernel.org

On Friday 29 August 2008, Rafael J. Wysocki wrote:
> Suspend to RAM is fine, hibernation (aka suspend to disk) is not (on my
> box). Does it mean that hibernation is fine on your box with
> 2.6.27-rc5, although shutdown is not?  That would require special
> DMI-dependent handling, so please double check.

Ah, right. The double spin down happens during hibernation too.

> Anyway, please attach the output of dmidecode to
> http://bugzilla.kernel.org/show_bug.cgi?id=8855
> so I can include your box into the final version of the patch.

Done.
