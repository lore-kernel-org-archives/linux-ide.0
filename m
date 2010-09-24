From: Seed <seedrubbish@gmail.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Fri, 24 Sep 2010 17:01:53 +1000
Message-ID: <AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com>
References: <4C9C3878.9010206@teksavvy.com> <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com>
 <4C9C44D0.1030409@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45704 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab0IXHCO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2010 03:02:14 -0400
Received: by wyb28 with SMTP id 28so1630395wyb.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Sep 2010 00:02:13 -0700 (PDT)
In-Reply-To: <4C9C44D0.1030409@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Sep 24, 2010 at 4:27 PM, Mark Lord <kernel@teksavvy.com> wrote:
> The bug seems to be in the libahci code somewhere.

ahci_qc_fill_rtf seems to be the function converting FIS to result_tf.

--
