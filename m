From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] Managed device resources, take #3
Date: Sat, 20 Jan 2007 16:00:26 +0900
Message-ID: <11692764262700-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:8229 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965081AbXATHAc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jan 2007 02:00:32 -0500
Received: by wx-out-0506.google.com with SMTP id h31so729708wxd
        for <linux-ide@vger.kernel.org>; Fri, 19 Jan 2007 23:00:32 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is the third iteration of devres patchset.  Changes from the last
take[L] are...

* devres patches collapsed into one as Jeff requested

* updates for sata_inic162x added

* rebased to the current upstream

Git tree is available at the following URLs.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=devres
  git://htj.dyndns.org/libata-tj devres

For detailed info, please read Documentation/driver-model/devres.txt.
Similar info can also be found from the initial take[I].

This patchset is against

[U]   libata-dev#upstream
[1] + sata_promise-kill-qc-nsect
[2] + lbiata-fix-compile-warning-caused-by-ignoring-__must_check results

The git tree contains both previous patches, but this patchset apply
okay with either one of or both patches omitted.

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.kernel/482455
[I] http://thread.gmane.org/gmane.linux.ide/14690
[U] 8ed22df2570dbb7df2bd161bb9381a6fd17de3d3
[1] http://article.gmane.org/gmane.linux.ide/15189
[2] http://article.gmane.org/gmane.linux.ide/15192


