From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] ahci updates regarding vt8251 support, take #2
Date: Mon, 16 Oct 2006 07:43:23 +0900
Message-ID: <11609522031228-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:62602 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932078AbWJOWnc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:43:32 -0400
Received: by nf-out-0910.google.com with SMTP id c2so624555nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:43:31 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, aalderd.boac@wanadoo.nl, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of vt8251-ahci patchset.  This patchset
updates libata and ahci to improve vt8251 EH and hotplug support.

#01 : separate out sata_port_hardreset(), to be used by vt8251 reset
#02 : update CLO handling in softreset and kill RESET_NEEDS_CLO
#03 : update vt8251 support in ahci

Changes from the last take[L] are

* rebased over the current upstream + hp-poll
* hp-poll callbacks added to ahci_vt8251_ops

This patchset is against
  upstream (da54f5fe54c7d75e2db7d17961fb36a8c28a8501)
  + hp-poll patchset, take #5 [1]

This patchset has been verified by me and Aalderd Bouwman
<aalderd.boac@wanadoo.nl>.

The git tree is avilable at

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=vt8251-ahci
  git://htj.dyndns.org/libata-tj vt8251-ahci

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/13449
[1] http://article.gmane.org/gmane.linux.ide/13467


