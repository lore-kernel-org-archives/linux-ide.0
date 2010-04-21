From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Wed, 21 Apr 2010 15:24:04 +0100
Message-ID: <20100421152404.62699040@lxorguk.ukuu.org.uk>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55784 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754610Ab0DUOTq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Apr 2010 10:19:46 -0400
In-Reply-To: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fang Wenqi <anton.fang@gmail.com>
Cc: jgarzik@redhat.com, linux-ide@vger.kernel.org, antonf@turbolinux.com.cn

On Wed, 21 Apr 2010 22:07:26 +0800
=46ang Wenqi <anton.fang@gmail.com> wrote:

>   CC      drivers/ata/libata-eh.o
> drivers/ata/libata-eh.c: In function =E2=80=98ata_eh_analyze_ncq_erro=
r=E2=80=99:
> drivers/ata/libata-eh.c:1642: warning: =E2=80=98tf.flags=E2=80=99 may=
 be used uninitialized in this function

Which compiler are you using. gcc 4.4.3 seems to have no trouble workin=
g
this out correctly and issues no warning ?
