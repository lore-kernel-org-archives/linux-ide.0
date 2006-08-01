From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve initialization and legacy handling
Date: Wed, 2 Aug 2006 05:11:48 +0900
Message-ID: <11544631081793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:2384 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932560AbWHAULz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 16:11:55 -0400
Received: by nf-out-0910.google.com with SMTP id o25so381332nfa
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 13:11:54 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.ukjgarzik@pobox.com, akpm@osdl.org, davej@redhat.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This patchset contains patches from Jeff Garzik, Alan Cox, Dave Jones
and me to fix/clean up initializaton and legacy handling.  This
patchset contains the following patches.

#01-05	: assorted fixes & clean ups to initiallization
#06-07	: kill host_set->next and handle legacy ports in one host_set
#08-11	: use dummy port for stolen legacy ports and kill hard_port_no

Tested both combined and native modes with ICH7R.  Everything seems to
work including stolen port handling.

This patchset is against the current libata-dev #upstream[1] and
available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream
  git://htj.dyndns.org/libata-tj tj-upstream

PATA drivers have been updated accordingly and available at

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-pata-drivers
  git://htj.dyndns.org/libata-tj tj-pata-drivers

Updated ALL branch is available at

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-ALL
  git://htj.dyndns.org/libata-tj tj-ALL

I'll post PATA patch separately for review.

Thanks.

--
tejun


