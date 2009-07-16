From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH v2 0/3] libata: expose port hotplug information to userspace
Date: Thu, 16 Jul 2009 20:58:07 +0100
Message-ID: <1247774290-4194-1-git-send-email-mjg@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34054 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810AbZGPT6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jul 2009 15:58:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Default ALPM policy should be influenced by whether or not it's plausible
for a port to be hotplugged. AHCI provides information on this, but it's
not sufficiently reliable to allow it to be used in-kernel. Exposing this
to userspace allows a more informed policy decision to be made.

