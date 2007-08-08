From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata-core: support wildcard matching in
 ata_blacklist_entry
Date: Thu, 9 Aug 2007 00:31:34 +0100
Message-ID: <20070809003134.12de8576@the-village.bc.nu>
References: <20070808202057.GA23314@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40924 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759431AbXHHXYL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 19:24:11 -0400
In-Reply-To: <20070808202057.GA23314@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, dmilburn@redhat.com

On Wed, 8 Aug 2007 15:20:57 -0500
David Milburn <dmilburn@redhat.com> wrote:

> Support the use of '*' in model_num and model_rev entries
> in ata_device_blacklist[].
> 
> CC: alan@lxorguk.ukuu.org.uk
> Signed-off-by: David Milburn <dmilburn@redhat.com>

Suggestion: Pull the match function out of line so you don't have two
copies of it and can remove all the wacky ? operators

something like this ? (untested)

	strpatterncmp(const char *name, const char *patt)
	{
		const char *p = strchr(patt, '*');
		if (p == NULL)
			p = patt + strlen(patt);
		return strncmp(name, patt, p-patt);
	}

