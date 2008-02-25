From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/3] IDE: Replace __FUNCTION__ with __func__
Date: Sun, 24 Feb 2008 16:04:48 -0800
Message-ID: <1203897888.19319.143.camel@localhost>
References: <20080224221113.5ddfe371@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:1951 "EHLO
	mail.perches.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbYBYAFM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 19:05:12 -0500
In-Reply-To: <20080224221113.5ddfe371@paolo-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Sun, 2008-02-24 at 22:11 +0100, Paolo Ciarrocchi wrote:
> -				"driver.\n", __FUNCTION__, drive->name);
> +				"driver.\n", __func__, drive->name);

Is there consensus on this style conversion?

Right now, there's 629 uses of __FUNCTION__ and 439 uses of __func__.


