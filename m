From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 04/11] merge irq-pio
Date: Thu, 11 May 2006 22:33:24 +0900
Message-ID: <11473544041507-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:49215 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751775AbWEKNdn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:33:43 -0400
Received: by py-out-1112.google.com with SMTP id f28so238502pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:33:43 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

Howdy,

This is part of patchset series described in [T].

This patchset contains merge of irq-pio branch.  This patchset is
composed of two patches - the first one is the merge and the second
one contains follow-up fixes.

THIS PATCHSET IS FOR REVIEW ONLY.  Please pull from the git tree
described in [T] for proper credit attribution and merge history.

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)
  + [1] prep-for-new-EH patchset
  + [2] new-EH-framework patchset, take 3
  + [3] new-EH-implementation patchset, take 3

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957
[1] http://article.gmane.org/gmane.linux.ide/9959
[2] http://article.gmane.org/gmane.linux.ide/9984
[3] http://article.gmane.org/gmane.linux.ide/9995


