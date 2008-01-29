From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Tue, 29 Jan 2008 19:17:53 +0200
Message-ID: <c70ff3ad0801290917y166af967h535d0dc9458cec5b@mail.gmail.com>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>
	 <1196610199229-git-send-email-saeed.bishara@gmail.com>
	 <47684270.5030405@garzik.org>
	 <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com>
	 <478DD615.1050309@garzik.org>
	 <c70ff3ad0801160817o28855b9byc6d314cef5a0d460@mail.gmail.com>
	 <478E5479.8070505@rtr.ca>
	 <c70ff3ad0801170624l32d91cd6v5adde66a296b7272@mail.gmail.com>
	 <479F5E90.4030101@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:12391 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760770AbYA2RRy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jan 2008 12:17:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3727742wah.23
        for <linux-ide@vger.kernel.org>; Tue, 29 Jan 2008 09:17:53 -0800 (PST)
In-Reply-To: <479F5E90.4030101@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>

>
> ACK the changes; but both git-am(1) and patch(1) report that this is a
> corrupt patch.  patch(1) says,
>
>
> [jgarzik@pretzel libata-dev]$ patch -sp1 < /g/tmp/mbox
> patch: **** malformed patch at line 151: *hpriv, int idx,
>
>
>
> (patch is generally more forgiving than git-am)
ok, I'll send the patch as [PATCH v2] in separate email with git-send-email.

saeed
