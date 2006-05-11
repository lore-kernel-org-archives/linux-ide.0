From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 01/11] prep for new EH
Date: Thu, 11 May 2006 20:59:49 +0900
Message-ID: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:9925 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751557AbWEKL75 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 07:59:57 -0400
Received: by nz-out-0102.google.com with SMTP id 13so170486nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 04:59:56 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is part of patchset series described in [T].

This is the first take of prep-for-new-EH patchset.  This patchset
contains 22 patches and can be grouped as follows.

#01-02: SCSI support for libata EH
#03-09: various fixes
#10-22: various new features

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)

New features worth mentioning are...

* Use statically allocated buffers.  dev->id[] is now statically
  allocated and ap->sector_buf[512] is added so that revalidation and
  NCQ read log don't have to allocate buffers during EH.  With this no
  allocation is necessary during EH except for PM link allocation
  which is done with GFP_NOIO and doesn't hamper operation of existing
  devices when it fails.

* qc->result_tf to carry resulting TF after command excution.  TF can
  be explicitly requested via ATA_QCFLAG_RESULT_TF.  LLDDs are
  responsible for filling it when a qc fails (done automatically for
  drivers implementing ->tf_read).  This change is necessary to
  natively support controllers which don't have single TF image like
  sil24 and makes the completion path more efficient.

* New SCR access and on/offline test functions defined.  This cleans
  up scattered SCR availability tests and allows for later PM
  extensions.

* Added dev->ap and remove many @ap arguments.  This simplifies codes
  and makes it much easier to add ata_link inbetween later.

* ata_*_printk() helpers.  links and devices will be identified
  differently on PM and no-PM cases.  Adding printk helpers seems to
  be the cleanest solution.  Maybe debug message handling can be
  integrated, too.  I don't know.

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957


