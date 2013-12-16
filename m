From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 2/2] ahci: only attach ICH6-M if it's in SATA mode
Date: Mon, 16 Dec 2013 21:47:32 +0100
Message-ID: <1387226852.14970.28.camel@x41.thuisdomein>
References: <1387190097.9255.31.camel@x41.thuisdomein>
	 <20131216155136.GF32509@htj.dyndns.org> <52AF384C.9020101@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:53441 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129Ab3LPUrf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Dec 2013 15:47:35 -0500
In-Reply-To: <52AF384C.9020101@linux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Levente Kurusa <levex@linux.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2013-12-16 at 18:28 +0100, Levente Kurusa wrote:
> Not only they use different class IDs, but IIRC they also change device ids.
> For example, ICH7M was 0x27C4 in AHCI mode and 0x27DF in IDE mode. (obviously
> Intel vendor ids)

Apparently ICH6-M always uses device ID 0x2653 for its SATA "function"
(whether in SATA mode or in IDE mode).

> Paul, did this patch change anything noticeable for you? I mean was there any
> problem before that this patch fixes or not?

What triggered these two patches was the warning I quoted in patch 1/2
(which Tejun already queued). Looking at the code involved raised the,
obvious, question why ahci bothers to attach to ICH6-M in IDE mode.
Anyhow, the only problem is that it unsuccessfully probes when ICH6-M is
in IDE mode. The probe doesn't break things, as far as I can tell.


Paul Bolle

