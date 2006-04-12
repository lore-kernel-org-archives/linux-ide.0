From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: HDIO_SCAN_HWIF causes hwif to "forget" PCI parent
Date: Wed, 12 Apr 2006 15:30:17 +0100
Message-ID: <1144852217.1952.34.camel@localhost.localdomain>
References: <200604080030.07236.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12986 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751150AbWDLOVT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Apr 2006 10:21:19 -0400
In-Reply-To: <200604080030.07236.arvidjaar@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sad, 2006-04-08 at 00:30 +0400, Andrey Borzenkov wrote:
> One of scripts called on Mandriva during suspend/resume calls hdparm -U for 
> hdc on suspend and hdparm -R on resume.

Thats not a good idea. These functions are not suitable for use with
anything but extremely specialised platforms and only when IDE is
quiescent, or on 2.4-ac.

Fix Mandriva not to vandalise the IDE configuration.

