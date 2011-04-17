From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [PATCH 3/4] ata: Add and use ata_print_version_once
Date: Sun, 17 Apr 2011 13:45:02 +0300
Message-ID: <BANLkTikeV-jHXWSDyLmtTTc1d2S9L3eG0Q@mail.gmail.com>
References: <cover.1302907496.git.joe@perches.com>
	<440aa7f6bb99bec705b83796894f843bfc1b7bf9.1302907497.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38907 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab1DQKpD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Apr 2011 06:45:03 -0400
In-Reply-To: <440aa7f6bb99bec705b83796894f843bfc1b7bf9.1302907497.git.joe@perches.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org

On Sat, Apr 16, 2011 at 1:52 AM, Joe Perches <joe@perches.com> wrote:
> Use a single mechanism to show driver version.
> Reduces text a tiny bit too.
>
> Remove uses of static int printed_version
> Add and use ata_print_version(const struct device *, const char *ver)
> and ata_print_version_once.
any idea why we really need this driver version for in-kernel drivers?
isn't the kernel version good enough?
saeed
