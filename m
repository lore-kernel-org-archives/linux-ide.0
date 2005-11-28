From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [RFC 2/5] ata_acpi: libata.h fields
Date: Sun, 27 Nov 2005 21:03:32 -0800
Message-ID: <20051127210332.433c2d43.rdunlap@xenotime.net>
References: <20051123154055.6ab5cab2.randy_d_dunlap@linux.intel.com>
	<20051123155103.7e58140c.randy_d_dunlap@linux.intel.com>
	<43850B7E.5010506@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:8386 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751239AbVK1FDC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Nov 2005 00:03:02 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sun, 27 Nov 2005 21:03:02 -0800
In-Reply-To: <43850B7E.5010506@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Falk <efalk@google.com>
Cc: randy_d_dunlap@linux.intel.com, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, 23 Nov 2005 16:38:22 -0800 Edward Falk wrote:

> Why do this in the libata layer rather than the block or device layers?
> -

Hi,

Thanks for your question.

There is some device-to-ACPI table associations that are needed.
I don't see how the block layer would be appropriate for that.
Could it be?

Also, calls must be made to each SATA device driver to perform
a raw taskfile write.

What do you mean by the device layer?  Maybe the ops function entries
in each SATA driver?  If so, it looks like I may need to add the
raw taskfile write as an entry there, but I haven't really
studied that very much yet.

Do you have some other (different) suggestions for doing this?

---
~Randy
