From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: several fixes against libata-dev#upstream-fixes
Date: Sat, 5 Aug 2006 05:45:57 +0900
Message-ID: <11547243571730-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:41949 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161416AbWHDUqE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 16:46:04 -0400
Received: by nz-out-0102.google.com with SMTP id n1so107720nzf
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 13:46:04 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff.

This patchset contains fixes against libata-dev#upstream-fixes[1].

#01    : fix ata_port_detach() dangling SCSI host bug
#02    : fix host_set private_data init bug
#03    : fix double free of host_set->mmio_base
#04-05 : fix ata_device_add() error path

#02, #04-05 are taken from rework-host_set patchset and #01, #03 are
new.  I left rework-host_set as update to #upstream as it is too much
for .18-rcX.

This patchset is available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=tj-upstream-fixes
  git://htj.dyndns.org/libata-tj tj-upstream-fixes

Thanks.

--
tejun

[1] f1d39b291e2263f5e2f2ec5d4061802f76d8ae67


