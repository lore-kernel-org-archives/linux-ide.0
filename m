From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] pata_it821x: Fix RAID type display
Date: Mon, 04 Jul 2011 18:49:39 +0400
Message-ID: <4E11D303.3060208@mvista.com>
References: <20110704153324.70a64e7c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:65406 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466Ab1GDOv3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jul 2011 10:51:29 -0400
Received: by fxd18 with SMTP id 18so5334728fxd.11
        for <linux-ide@vger.kernel.org>; Mon, 04 Jul 2011 07:51:28 -0700 (PDT)
In-Reply-To: <20110704153324.70a64e7c@endymion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Jean Delvare wrote:

> The missing comma causes the wrong RAID type to be displayed.
> Introduced by commit 963e4975c6f93c148ca809d986d412201df9af89 three

    Please also specify that commit's summary in parens.

> years ago, odd that nobody noticed before.

> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

WBR, Sergei
