From: "Guillermo A. Amaral" <g@maral.me>
Subject: libata-core: Trim blacklist entry for refurbished M500 SSDs
Date: Tue, 25 Aug 2015 23:29:12 -0700
Message-ID: <1440570553-1600-1-git-send-email-g@maral.me>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34094 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbHZG3n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2015 02:29:43 -0400
Received: by iodb91 with SMTP id b91so7476515iod.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2015 23:29:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

I recently got my hands on an "Factory reCertified" (FC) Crucial M500 drive and
noticed it was giving me errors when fstrim ran, much like they did back a few
years ago.

It seems Crucial modified the model numbers and hence, no longer get
blacklisted, so I fixed it right away.

I think, it should be the same for the M550s... I'll have to check when I get
my hands on one.

