From: Bian Naimeng <biannm@cn.fujitsu.com>
Subject: On AHCI CCC
Date: Fri, 11 May 2012 14:54:05 +0800
Message-ID: <4FACB78D.90100@cn.fujitsu.com>
References: <4FA74F90.7070209@cn.fujitsu.com> <4FA7ABFC.2070505@cn.fujitsu.com> <4FA8E2BD.3010107@cn.fujitsu.com> <4FA8E98C.4070104@cn.fujitsu.com> <4FA9CA7F.4020802@cn.fujitsu.com> <4FAA329E.4090809@cn.fujitsu.com> <4FAB8F40.5020701@cn.fujitsu.com> <4FAB930D.2000204@cn.fujitsu.com> <4FAC7A62.7060704@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Shift_JIS
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:35498 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1761663Ab2EKG4N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2012 02:56:13 -0400
In-Reply-To: <4FAC7A62.7060704@cn.fujitsu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, fnst-fslbsp@cn.fujitsu.com

Hi, Jeff
 
  I'm trying to do some work related to ahci module of linux kernel.
  But I found that Command Completion Coalescing(CCC)
  has not been supported until kernel version 3.0.

  I just wonder why it be dropped?
  What's your consideration about it?
  And will you add this feature later?
 
Regards
  Bian

