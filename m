From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22] Add LED trigger to libata core
Date: Mon, 19 Mar 2007 13:42:37 +0900
Message-ID: <45FE14BD.5090701@gmail.com>
References: <20070318170605.3751D5B80F1@ganymede.vroon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:39781 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbXCSEmm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 00:42:42 -0400
Received: by nz-out-0506.google.com with SMTP id s1so558615nze
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 21:42:41 -0700 (PDT)
In-Reply-To: <20070318170605.3751D5B80F1@ganymede.vroon.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Vroon <chainsaw@gentoo.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tony Vroon wrote:
> This duplicates the IDE core LED trigger in the libata core.
> I plan to use this by allowing PMU LED control on G5 towers. My test platform 
> is a PowerMac 7,3 (Dual G5 2.0GHz, June 2004) with a K2 (sata_svw) controller.

I think this fits better in libata-core.c::ata_qc_issue().  Can you move
it to there?

-- 
tejun
