From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] implement and use port_task
Date: Sun, 5 Mar 2006 15:29:09 +0900
Message-ID: <1141540149886-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:14064 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752017AbWCEG3P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 01:29:15 -0500
Received: by pproxy.gmail.com with SMTP id d42so559832pyd
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 22:29:13 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff and Albert.

This patchset implements port_task and replace pio_task and
packet_task with it.  port_task isn't very different from pio_task or
packet_task - it's straight forward generalization.  The port_task is
a per-port task avaliable to low level drivers which is managed by
libata core layer.

Differences from pio/packet task.

* Not limited to PIO HSM implementation.  Other drivers can use it.

* Synchronization against EH core layer is done within libata core
  layer, not in PIO HSM implementation (ata_qc_timeout()).

Thanks.

--
tejun

