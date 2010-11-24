From: Tobias Karnat <tobias.karnat@googlemail.com>
Subject: Re: sata_sil24: external raid storage mistaken as port multiplier
Date: Wed, 24 Nov 2010 05:23:08 +0100
Message-ID: <1290572588.24847.20.camel@Tobias-Karnat>
References: <1290461073.12443.21.camel@Tobias-Karnat>
	 <1290514125.28293.2.camel@Tobias-Karnat>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45771 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab0KXEXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Nov 2010 23:23:14 -0500
In-Reply-To: <1290514125.28293.2.camel@Tobias-Karnat>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi,

I got it fixed by removing ATA_FLAG_PMP from the SIL24_COMMON_FLAGS.

Could someone turn this into a module option?

The external raid case might in fact has a built-in port multiplier,
but the case can only be configured as raid0 and raid1.

I suspect that Linux tries to to access the drives separately, which fails.

-Tobias

