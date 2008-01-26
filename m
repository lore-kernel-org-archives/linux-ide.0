From: Frans Pop <elendil@planet.nl>
Subject: Re: From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  (linux.* mail to news gateway)
Date: Sat, 26 Jan 2008 21:31:41 +0100
Message-ID: <E1JIrgj-0005cj-Gv@faramir.fjphome.nl>
References: <200801262043.17739.bzolnier@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml13.kpnxchange.com ([213.75.38.113]:49388 "EHLO
	hpsmtp-eml13.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752799AbYAZUbo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jan 2008 15:31:44 -0500
In-reply-To: <200801262043.17739.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

>  config BLK_DEV_IDE_PMAC
> -       bool "Builtin PowerMac IDE support"
> +       tristate "Builtin PowerMac IDE support"

This does not seem to make sense: if the option is now tristate, it is no
longer "Builtin", so probably s/Builtin // in the description.

Cheers,
FJP
