From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2 #upstream] ahci: preserve PORTS_IMPL over host resets
Date: Tue, 07 Nov 2006 04:46:32 -0500
Message-ID: <455055F8.9000707@pobox.com>
References: <20061102031723.GV13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31668 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754157AbWKGJqh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Nov 2006 04:46:37 -0500
In-Reply-To: <20061102031723.GV13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: robbat2@gentoo.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Instead of writing 0xf blindly, preserve the content of write-once
> PORTS_IMPL register over host resets.
> 
> This patch is taken from Jeff Garzik's AHCI init update patch.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


