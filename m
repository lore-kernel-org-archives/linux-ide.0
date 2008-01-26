From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  (linux.*
 mail to news gateway)
Date: Sat, 26 Jan 2008 21:42:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801262142300.15243@fbirervta.pbzchgretzou.qr>
References: <200801262043.17739.bzolnier@gmail.com> <E1JIrgj-0005cj-Gv@faramir.fjphome.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:39083 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbYAZUml (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jan 2008 15:42:41 -0500
In-Reply-To: <E1JIrgj-0005cj-Gv@faramir.fjphome.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org


On Jan 26 2008 21:31, Frans Pop wrote:
>>  config BLK_DEV_IDE_PMAC
>> -       bool "Builtin PowerMac IDE support"
>> +       tristate "Builtin PowerMac IDE support"
>
>This does not seem to make sense: if the option is now tristate, it is no
>longer "Builtin", so probably s/Builtin // in the description.

Or something like s/Builtin/Onboard/;
