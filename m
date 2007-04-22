From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: improve ATA ACPI support
Date: Mon, 23 Apr 2007 02:41:05 +0900
Message-ID: <11772636651400-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:42374 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbXDVRlM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:41:12 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1107246nze
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 10:41:12 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This patchset improves ATA ACPI support as proposed in the following
message.

  http://article.gmane.org/gmane.linux.ide/17554

Improvements are...

* safe and simpler ACPI node association

* major code cleanup

* invoke ACPI methods only when ACPI spec says necessary

* proper ACPI error handling with a retry

* after successfully executing _GTF taskfiles, IDENTIFY page is
  reloaded

* _GTM/_STM support

This patchset is composed of 13 patches.

#01-02 : misc preparation
#03-04 : separate out ata_dev_reread_id() and make revalidation robust
	 against size change during device configuration
#05-06 : clean up libata-acpi.c
#07-08 : implement ata_acpi_associate()
#09-10 : more cleanups
#11-13 : reimplement ACPI invocation so that methods are called where
	 the spec specifies and errors are properly handled, and add
	 _GTM/_STM support.

Tested on three desktop boards (nf ultra, ich7 and ich8) and a
notebook.  This patchset is against...

  upstream (5365067b4bb17d1801fefe995d1342108b324471)
  + [1] pata_amd-remove-contamination
  + [2] libata-add-missing-call-to-cable_detect-in-new-EH
  + [3] libata-acpi-fix-GTF-command-protocol-for-ATAPI

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/18120
[2] http://article.gmane.org/gmane.linux.ide/18121
[3] http://article.gmane.org/gmane.linux.ide/18122


