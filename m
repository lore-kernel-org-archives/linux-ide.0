From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/21] ide: dump taskfile HOB registers in ide_tf_load()
 (if DEBUG is defined)
Date: Mon, 19 Nov 2007 15:14:53 +0300
Message-ID: <47417E3D.2000406@ru.mvista.com>
References: <200711182310.48607.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:26944 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752788AbXKSMOj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 07:14:39 -0500
In-Reply-To: <200711182310.48607.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Dump taskfile HOB registers in ide_tf_load() (if DEBUG is defined).

> * Remove no longer needed DEBUG code from __ide_do_rw_disk().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
