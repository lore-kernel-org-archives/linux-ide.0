From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 0/2] ata: MODE SELECT implementation
Date: Thu,  5 Jul 2012 11:40:33 +0200
Message-ID: <1341481235-12708-1-git-send-email-pbonzini@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This is a revised version of the MODE SELECT implementation from yesterday,
augmented with support for changeable parameter requests in MODE SENSE.

Paolo Bonzini (2):
  ata: support MODE SENSE request for changeable parameters
  ata: implement MODE SELECT command

 drivers/ata/libata-scsi.c |  242 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 221 insertions(+), 21 deletions(-)
