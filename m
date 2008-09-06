From: Frans Pop <elendil@planet.nl>
Subject: Re: Regression: SATA disk double spin-off during hibernation on hp nx6325
Date: Sat, 6 Sep 2008 02:09:35 +0200
Message-ID: <200809060209.37353.elendil@planet.nl>
References: <200808290002.55026.rjw@sisk.pl> <200809060025.20039.elendil@planet.nl> <200809060118.38493.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpo-eml06.kpnxchange.com ([213.75.38.155]:11690 "EHLO
	cpsmtpo-eml06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002AbYIFAJl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Sep 2008 20:09:41 -0400
In-Reply-To: <200809060118.38493.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, trenn@suse.de, htejun@gmail.com, hancockr@shaw.ca, linux-kernel@vger.kernel.org, Maciej Rutecki <maciej.rutecki@gmail.com>

On Saturday 06 September 2008, Rafael J. Wysocki wrote:
> Thanks.  There's a new patch for you to test in there already. :-)

Seems to work correctly. The first spindown no longer happens.

In the BTS you noted the support is "partial". What's partial about it?

Thanks Rafael.
