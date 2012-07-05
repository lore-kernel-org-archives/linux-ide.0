From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 0/2] ata: MODE SELECT implementation
Date: Thu,  5 Jul 2012 14:18:19 +0200
Message-ID: <1341490701-15348-1-git-send-email-pbonzini@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: sshtylyov@mvista.com, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

This is a revised version of the MODE SELECT implementation from yesterday,
augmented with support for changeable parameter requests in MODE SENSE.

Paolo Bonzini (2):
  ata: support MODE SENSE request for changeable parameters
  ata: implement MODE SELECT command

 drivers/ata/libata-scsi.c |  242 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 221 insertions(+), 21 deletions(-)
