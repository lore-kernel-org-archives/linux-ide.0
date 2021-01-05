Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D969BC433DB
	for <linux-ide@archiver.kernel.org>; Tue,  5 Jan 2021 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFF722C7B
	for <linux-ide@archiver.kernel.org>; Tue,  5 Jan 2021 15:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbhAEPq5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:46:57 -0500
Received: from mailscanner.iro.umontreal.ca ([132.204.25.50]:25741 "EHLO
        mailscanner.iro.umontreal.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbhAEPq5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2021 10:46:57 -0500
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 10:46:56 EST
Received: from pmg1.iro.umontreal.ca (localhost.localdomain [127.0.0.1])
        by pmg1.iro.umontreal.ca (Proxmox) with ESMTP id A7E411002F2;
        Tue,  5 Jan 2021 10:36:19 -0500 (EST)
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
        by pmg1.iro.umontreal.ca (Proxmox) with ESMTP id 8FB1210022E;
        Tue,  5 Jan 2021 10:36:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
        s=mail; t=1609860977;
        bh=w5eBZ6mapn8fdXzev4p7f/dNItxYjUeLy+rl7gzoSAU=;
        h=From:To:Subject:Date:From;
        b=mwb2LhEsbGQFQp94FOEQbDeQA3YhUa6iDoUY1ugORt6J/YtwN2nY5jRGL9fYDLmaP
         NKJ6UXX9jMjOomcTyPqRVqfrx478RXzzfHPZThPdE8Rrl2htFJWqkpLDqqtg0mOPCg
         OdhVrInvB6wZK6CALKWHovydFuFHOb5HasiWPlnzXVvy18t0uT2nTdpD9B6TGNd0zR
         fwDOXSpCSlkzwEbjNdiIcdmb72gf1E1TMQ52Z+jn1s+IEFcKeIjgc4UMgBlDWIEuES
         qgjdbKVZq2mNWbwKadJp8JQ8DlDhrirIqRPmRp1Jzs8hbMh6tKsC/IQjoO1cASw5kg
         fu/RJFQ2T0sZQ==
Received: from alfajor (unknown [104.247.243.191])
        by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 6A78B12043F;
        Tue,  5 Jan 2021 10:36:17 -0500 (EST)
From:   Stefan Monnier <monnier@iro.umontreal.ca>
To:     linux-ide@vger.kernel.org
Subject: "80-wire cables" issue when using SATA drives in PATA Thinkpads
Message-ID: <jwvczyjxvb7.fsf-monnier+Inbox@gnu.org>
Date:   Tue, 05 Jan 2021 10:36:16 -0500
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

[ Not sure where to send this question.
  This mailing-list seems to be much more oriented towards development of
  libata code than its use, but the question seems too technical for
  other foras.  ]

I'm trying to use a SATA M.2 drive in a Thinkpad X30 (via a PATA->M.2
enclosure) and am bumping into a ~30MB/s bandwidth limit that's
apparently imposed by the BIOS for "lack" of an 80-wire cable.

This is mentioned at the end of
https://www.thinkwiki.org/wiki/How_to_put_SATA_in_old_ThinkPads
and links to
https://forum.thinkpads.com//viewtopic.php?f=31&t=115478&p=741729

which mentions this as a known problem.
Is there some known workaround for it?

I tried to boot with `libata.force=80c` and it does result in `hdparm`
claiming that `udma5` is used instead of `udma2`, but that seems to be
a lie because the actual bandwidth I see is still ~30MB/s.

How can I diagnose the problem further (and ideally fix it)?


        Stefan

