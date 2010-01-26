From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Tue, 26 Jan 2010 16:02:43 +0000
Message-ID: <20100126160243.018b87e3@lxorguk.ukuu.org.uk>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58189 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754317Ab0AZQGK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2010 11:06:10 -0500
In-Reply-To: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, vishalrao@gmail.com, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

> Should work with 64, 128 (tested) and 256 GB capacities with any
> firmware versions in
> drivers/ata/libata-core.c because of ATA errors in dmesg, hangs and
> filesystem corruption.

If you've only tested one type why list all three ? Also you've not
listed a firmware version so do you know which are affected ?

What controllers did you test with ?

Alan
