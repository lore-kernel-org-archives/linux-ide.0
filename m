From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] Managed device resources, take #2
Date: Wed, 10 Jan 2007 14:35:35 +0900
Message-ID: <11684073353213-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:40997 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583AbXAJFfr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jan 2007 00:35:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so399249nfa
        for <linux-ide@vger.kernel.org>; Tue, 09 Jan 2007 21:35:45 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is the second take of devres patchset.  Changes from the last
take[L] are...

* generic managed iomap interface functions implemented
	- devm_ioport_map/unmap()
	- devm_ioremap[_nocache](), devm_iounmap()

* libata-sff legacy mode now uses generic managed iomap interface
  intead of implementing its own devres

* all pata drivers have been converted

* Documentation/driver-model/devres.txt added

Git tree is available at the following URLs.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=devres
  git://htj.dyndns.org/libata-tj devres

For detailed info, please read Documentation/driver-model/devres.txt.
Similar info can also be found from the last post.

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/14690


