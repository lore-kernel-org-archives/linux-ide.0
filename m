From: Timur Tabi <timur.tabi@calxeda.com>
Subject: Re: [PATCH v2] ata: increase retry count but shorten duration for
 Calxeda controller
Date: Thu, 30 May 2013 09:26:31 -0500
Message-ID: <51A76197.9080708@calxeda.com>
References: <1369923509-3246-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp181.iad.emailsrvr.com ([207.97.245.181]:45151 "EHLO
	smtp181.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932905Ab3E3Ogj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 May 2013 10:36:39 -0400
In-Reply-To: <1369923509-3246-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 05/30/2013 09:18 AM, Mark Langsdorf wrote:
> -	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
> +	const unsigned long timing[] = { 5, 100, 500};

You'll save space and time if you also make this array "static",
otherwise the compiler will build the array every time this function is
called.

-- 
Timur Tabi
Software Developer at Calxeda
